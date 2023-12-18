require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /signup" do#何のテストをするか(describeの後の中身はなんでもいい)
    user_id = "test_user"
    password = "password"

    # 各テストケースの最初に実行する処理
    before do
      post "/signup", params: {user_id: user_id, password: password}#/signupにpostで送る
    end

    it "サインアップが成功する" do
      expect(response).to have_http_status(200)#ヘッダーのstatusが200かどうか
    end

    it "レスポンスの値が意図したものになっている" do
      expected_body = {#expected_bodyは返ってきてほしいbodyの値
        "user_id" => user_id,
        "password" => password
      }

      #response.parsed_bodyはresponseのbodyの値

      expect(response.parsed_body).to eq(expected_body)
    end
  end

  describe "GET /user/:id" do
    before do
       #なぜかfactoryを使ってモデルをcreateする
       #別にUser.create()でもいいと思うんだが、テストの際は基本的にこうやってモデルをcreateするらしい
       @user = FactoryBot.create(:user)
       @headers = { HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials(@user.user_id, @user.password)} #認証情報(Basic)を持ったヘッダ
    end

    it "認証情報なしでリクエストを送ると401が返ってくる" do
      get "/users/#{@user.id}"

      expect(response).to have_http_status(401)
    end

    it "認証情報(Basic)ありでリクエストを送ると、200が返ってくる" do
      get "/users/#{@user.id}", headers: @headers

      expect(response).to have_http_status(200)
    end

    it "認証情報ありリクエストを送ると意図したレスポンスが返ってくる" do
      expected_body = {
        "user_id" => @user.user_id,
        "password" => @user.password
      }

      get "/users/#{@user.id}", headers: @headers

      expect(response.parsed_body).to eq(expected_body)
    end
  end

  describe "PATCH /users/:id" do
    it "認証情報なしでリクエストを送ると、401が返ってくる" do
      patch "/users/#{@user.id}"

      expect(response).to have_http_status(401)
    end    

    before do
      @user = FactoryBot.create(:user)
      @request_body = {nickname: "panda", comment: "hello"}
      headers = { HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials(@user.user_id, @user.password)} #認証情報(Basic)を持ったヘッダ
    
      patch "/users/#{@user.id}", headers: headers, params: @request_body
    end

    it "認証情報(Basic)ありでリクエストを送ると、200が返ってくる" do
      expect(response).to have_http_status(200)
    end

    it "認証情報ありリクエストを送ると意図したレスポンスが返ってくる" do
      expected_body = {
        "nickname" => @request_body[:nickname],
        "comment" => @request_body[:comment]
      }
      expect(response.parsed_body).to eq(expected_body)
    end
  end
end
