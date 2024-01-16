class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show destroy ]

  def index
    @tickets = Ticket.all.order(created_at: :desc)
    @total_individual = Ticket.where(promo: false).sum(:burger_quantity)
    @total_individual_tokens = Ticket.where(promo: false).sum(:burger_quantity) * 1.5
    @total_promo = Ticket.where(promo: true).sum(:burger_quantity)
  end

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

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.promo == true ? @ticket.burger_quantity = @ticket.burger_quantity * 2 : @ticket.burger_quantity
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:burger_quantity, :promo)
  end
end
