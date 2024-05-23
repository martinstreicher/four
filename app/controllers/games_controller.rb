class GamesController < ApplicationController
  before_action :check_for_active_game, only: %i[index]

  def new
    session[:game] = Board.new
    redirect_to games_path
  end

  def index
    game =
      Board.from_grid(
        session[:game]['grid'],
        columns: session[:game]['columns'],
        rows:    session[:game]['rows']
      )

    render locals: { game: game }
  end

  private

  def check_for_active_game
    return if session[:game].present?

    session[:game] = Board.new
    redirect_to games_path
  end
end
