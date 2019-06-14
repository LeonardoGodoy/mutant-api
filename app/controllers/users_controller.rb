class UsersController < ApplicationController
  def login
    user = User.find_by(login_params)
    ap user
    
    if user.present?
      render json: { message: 'Usuário logado com sucesso' }, status: :ok
    else
      render json: { message: 'Credenciais inválidas' }, status: :forbidden
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
