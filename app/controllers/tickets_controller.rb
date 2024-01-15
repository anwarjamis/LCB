class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show destroy ]

  # GET /tickets or /tickets.json
  def index
    @tickets = Ticket.all.order(created_at: :desc)
    @total = Ticket.all.sum(:burger_quantity)
  end

  # GET /tickets/1 or /tickets/1.json or /tickets/1.pdf
  def show
    respond_to do |format|
      format.html
      format.json
      format.pdf { render pdf: 'ticket_pdf',
                   template: 'tickets/ticket_pdf',
                   page_size: 'A7',
                   margin: { bottom: 0 } }
    end
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully created." }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:burger_quantity)
    end
end