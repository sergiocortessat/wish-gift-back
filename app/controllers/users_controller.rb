class UsersController < SecuredController
  skip_before_action :authorize_request, only: [:index, :show]
  before_action :set_user, only: %i[show update destroy]
  #   validates_presence_of :body, :published

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:sub, :email, :name, :given_name, :family_name, :picture)
  end
end


# class UsersController < SecuredController
#   skip_before_action :authorize_request, only: %i[index show]

#   def index
#     users = User.all
#     render json: users, include: { coins: { include: { goals: { include: :measurements } } } }
#   end

#   def show
#     user = User.find_by(sub: params[:id])
#     render json: user, include: { coins: { include: { goals: { include: :measurements } } } }
#   rescue ActiveRecord::RecordNotFound
#     head :not_found
#   end

#   def create
#     user = User.create!(user_params)
#     render json: user, status: :created
#   end

#   private

#   def user_params
#     params.permit(:sub, :email, :name, :given_name, :family_name, :picture)
#   end
# end