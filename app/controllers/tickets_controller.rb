class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show destroy ]

  def index
    @tickets = Ticket.all.order(created_at: :desc)
    @burgers = Ticket.sum(:burger_quantity)
    @veggies = Ticket.sum(:veggie_quantity)
    @drinks = Ticket.sum(:drink_quantity)
    @token_total = Ticket.sum(:tokens)
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
    @veggies = Ticket.sum(:veggie_quantity)
    @ticket = Ticket.new
  end
  
  def create
    @ticket = Ticket.new(ticket_params)
    set_default_values(@ticket)
    @ticket.tokens = @ticket.burger_quantity * 1.5 + @ticket.veggie_quantity * 1.5 + @ticket.drink_quantity * 0.5
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
    params.require(:ticket).permit(:burger_quantity, :veggie_quantity, :drink_quantity, :promo)
  end

  def set_default_values(ticket)
    ticket.burger_quantity ||= 0
    ticket.veggie_quantity ||= 0
    ticket.drink_quantity ||= 0
  end
end
