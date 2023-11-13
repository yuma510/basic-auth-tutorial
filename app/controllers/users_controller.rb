class UsersController < ApplicationController
    #paramsは送られてきた値を受け取る

    def create
        #user_idとpassword、他のデフォルトの変数をもったuserクラスをつくる。
        user = User.new(user_id: params["user_id"], password: params["password"])
        if user.save
            render json: {message: "Success to signup!", user: user}#ユーザ作成に成功した場合は、作成されたユーザの情報を返す
        else
            errors = user.errors.full_message
            render json: {message: "Failed...", errors: errors}#ユーザ作成に失敗した場合は、エラーメッセージを返す
        end
    end

    def show
        user = User.find(params["id"])#Userモデルのid番目を取得
        render json: {user: user}
    end

end
