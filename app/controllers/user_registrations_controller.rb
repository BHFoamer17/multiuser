class UserRegistrationsController < Devise::RegistrationsController

  def create
    # raise params.inspect
    meta_type = params[:user][:meta_type]
    meta_type_params = params[:user][meta_type]

    params[:user].delete(:meta_type)
    params[:user].delete(meta_type)

    build_resource(sign_up_params)

    child_class = meta_type.camelize.constantize
    # child_class == 'Provider' || 'Tenant'
    # child_class.new(params[child_class.to_s.underscore.to_sym])
    resource.meta = child_class.new(meta_type_params)

    # first check if child intance is valid
    # cause if so and the parent instance is valid as well
    # it's all being saved at once
    valid = resource.valid?
    valid = resource.meta.valid? && valid

    # customized code end
    if valid && resource.save    # customized code
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  end

  protected

    def after_sign_up_path_for(resource)
      after_sign_in_path_for(resource)
    end

    def after_update_path_for(resource)
      case resource
      when :user, User
        resource.meta? ? another_path : root_path
      else
        super
      end
    end
end
