class Ability
  include CanCan::Ability

  def initialize(user)
    cannot :manage, :all
    if user.is_a? Admin
      can :manage, Crowd
      can :manage, Subject
      can :manage, Student
      can :manage, Professor
      can :manage, Enrollment
      can :manage, ActivityLog
    elsif user.is_a? Professor
      can :manage, Messages::Topic
    elsif user.is_a? Student
      can :read, Messages::Topic
      can :create, Messages::Topic
      can :read, Messages::Message
      can :create, Messages::Message
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
