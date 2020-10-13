class Users::RegistrationsController < Devise::RegistrationsController


    def update_resource(resource, params)
      if current_user.provider == "amazon"
        params.delete("current_password")
        resource.update_without_password(params)
      else
        resource.update_with_password(params)
      end
    end

    def update 
        @user = User.find_by(id: current_user.id)
        if @user.update(params_update)
          @user.save
          redirect_to root_url
        else
          redirect_to edit_user_path(@user)
        end
      end
      
      private
  
      def params_update
        params.require(:user).permit(:shipping_name, :email, :shipping_address, :city, :state, :zip, :username)
      end
  end