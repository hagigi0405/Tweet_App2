class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end
  #投稿一覧
  #DBのPostテーブルからすべてのデータを取得し、＠変数名へ代入
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
  end  
  #投稿詳細(show.html)
  #params[:id]で、ルーティングで設定したURLのidを取得する
  #params[:id]で取得したidをfind_byメソッドで
  #そのidに合致するidをDBから取得する
  
  def new
    @post = Post.new
  end  
  
  def create
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id
      )
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end
  #newメソッドを使い新しくcontentを作成と共に現在ログインしているユーザーのidを取得
  #if文を用いて投稿の保存に成功した時と失敗した時の処理を書く
  #renderメソッドを用いる事で指定したURLへ直接ビューを表示できる
  #そのcontentをDBにセーブしindexへリダイレクト
  
  def edit
    @post = Post.find_by(id: params[:id])
  end  
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end  
  
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @current_user.id != @post.user_id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
end
