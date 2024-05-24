class MovesController < ApplicationController
  def edit
    board =
      Board.from_grid(
        session[:game]['grid'],
        columns: session[:game]['columns'],
        rows:    session[:game]['rows']
      )

    board_manager = BoardManagerService.new(board)
    row = board_manager.insert(player: session[:player], column: move_param.to_i)
    session[:game] = board

    if WinningConditionService.new(board: board, player: session[:player], position: { column: move_param.to_i, row: row }).won?
      redirect_to games_path, notice: "Player #{session[:player]} won!"
      return
    end

    swap_players
    redirect_to(games_path)
  rescue BoardManagerService::IllegalMoveError
    flash[:error] = 'Illegal move'
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
