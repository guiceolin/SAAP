# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|

  config.wrappers :bootstrap3, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'controls row' do |be|
      be.use :input, wrap_with: { tag: 'div', class: 'col-lg-4' }
      be.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      be.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.default_wrapper = :bootstrap3

  config.boolean_style = :nested

  config.button_class = 'btn'
  config.label_class = 'control-label'
  config.input_class = 'form-control'

  config.browser_validations = false

end
