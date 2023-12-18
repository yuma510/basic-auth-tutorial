include ActionController::HttpAuthentication::Basic::ControllerMethods #authenticate_or_request_with_http_basicメソッドがこのモジュールに含まれてるから、includeする

class UsersController < ApplicationController
    #paramsは送られてきた値を受け取る


    before_action :basic_auth, only:[:show, :update, :destroy]#showアクション実行前のみbasic_authを行う

    def destroy
        @current_user.destroy
        users = User.all
        render json: {users: users}#ちゃんとユーザが削除されたか確認するため、ユーザ一覧を返している
    end

    def update
        @current_user.update(nickname: params["nickname"], comment: params["comment"])
        render json: {user: @current_user}
    end

    def index
        users = User.all
        render json: {users: users}
    end

    def show
        # user = User.find(params["id"])#Userモデルのid番目を取得
        # render json: {user: user}
        
        # Basic認証ではブラウザに認証情報を保存する。
        # 認証が必要な処理の場合は、リクエスト時に認証情報をサーバに送り、都度その認証情報が正しいか検証する。
        # 下記では便宜上、認証情報をレスポンスに含んでいるが、本来は認証情報を送り返すなんてことはしないはず。てかやっちゃダメ。
        #  auth = request.headers["Authorization"]
        #  render json: {user: @current_user, auth: auth}
        render json: @current_user.as_json(only: [:user_id, :password])
    end


    def create
        #user_idとpassword、他のデフォルトの変数をもったuserクラスをつくる。
        user = User.new(user_id: params["user_id"], password: params["password"])
        if user.save
            # render json: {message: "Success to signup!", user: user}#ユーザ作成に成功した場合は、作成されたユーザの情報を返す
            render json: user.as_json(only: [:user_id, :password])
        else
            errors = user.errors.full_message
            render json: {message: "Failed...", errors: errors}#ユーザ作成に失敗した場合は、エラーメッセージを返す
        end
    end

    private

    def basic_auth #TODO: basic認証わからん
        authenticate_or_request_with_http_basic do |user_id, password|
            @current_user = User.find_by(user_id: user_id, password: password)#インスタンス変数に代入することで、users_controller内のどこからでも、@current_userを参照できる
            !!@current_user #true or false
        end
    end
end
