class MovesController < ApplicationController
  def edit
    board =
      Board.from_grid(
        session[:game]['grid'],
        columns: session[:game]['columns'],
        rows:    session[:game]['rows']
      )

    board_manager = BoardManagerService.new(board)
    board_manager.insert(player: session[:player], column: move_param.to_i)

    swap_players
    session[:game] = board
    redirect_to games_path
  end

  private

  def move_param
    params.require(:id)
  end

  def swap_players
    session[:player] = session[:player] == 'X' ? '0' : 'X'
  end
end
