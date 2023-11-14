# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    User.create!(email: 'test@example.com', password: 'test001')
    # ログイン
    visit new_user_session_path
    fill_in 'user_email', with: 'test@example.com'
    fill_in 'user_password', with: 'test001'
    click_on 'ログイン'
  end

  test 'submit report' do
    click_on '日報'
    click_on '日報の新規作成'
    fill_in 'タイトル', with: 'タイトル1'
    fill_in '内容', with: '内容1'
    click_on '登録する'
    assert_text '日報が作成されました。'
  end

  test 'update report' do
    click_on '日報'
    click_on '日報の新規作成'
    fill_in 'タイトル', with: 'タイトル1'
    fill_in '内容', with: '内容1'
    click_on '登録する'
    click_on 'この日報を編集'
    fill_in 'タイトル', with: 'タイトル1-modified'
    fill_in '内容', with: '内容1-modified'
    click_on '更新する'
    assert_text '日報が更新されました。'
  end

  test 'delete report' do
    click_on '日報'
    click_on '日報の新規作成'
    fill_in 'タイトル', with: 'タイトル1'
    fill_in '内容', with: '内容1'
    click_on '登録する'
    click_on 'この日報を削除'
    assert_text '日報が削除されました。'
  end
end
