require 'active_support/concern'
module SoftDestroy
  extend ActiveSupport::Concern

  included do
    alias :permanent_destroy :destroy
    scope :not_soft_destroyed, -> { where(deleted_at: nil) }
    scope :soft_destroyed, -> { where('deleted_at is not NULL') }

    def destroy
      run_callbacks(:destroy) do
        if soft_destroyed?
          self.destroy_dependencies
          permanent_destroy
        else
          soft_destroy
        end
      end
    end

  end

  def soft_destroyed?
    !!self.deleted_at
  end

  def soft_destroy
    self.deleted_at = Time.now
    self.destroy_dependencies
    self.save!(validate: false)
    self
  end

  def destroy_dependencies
    dependencies_with_destroy.each do |name, reflection|
     self.association(name).handle_dependency
    end
  end

  private

  def dependencies_with_destroy
    self.class.reflections.select do |name, reflection|
      reflection.options[:dependent].to_s == 'destroy'
    end
  end
end
