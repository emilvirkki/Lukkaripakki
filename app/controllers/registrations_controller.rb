class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    flash[:notice] = t('devise.registrations.signed_up_but_unconfirmed')
    NavItem.default_page
  end
end