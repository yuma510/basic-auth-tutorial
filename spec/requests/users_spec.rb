require 'rails_helper'

RSpec.describe "Users", type: :request do
  # describe "GET /index" do
  #   pending "add some examples (or delete) #{__FILE__}"
  describe "POST /signup" do
    user_id = "test_user"
    password = "password"

    # 各テストケースの最初に実行する処理
    before do
      post "/signup", params: {user_id: user_id, password: password}
    end

    it "サインアップが成功する" do
      expect(response).to have_http_status(200)
    end

    it "レスポンスの値が意図したものになっている" do
      expected_body = {
        "user_id" => user_id,
        "password" => password
      }

      expect(response.parsed_body).to eq(expected_body)
    end
  end
end
