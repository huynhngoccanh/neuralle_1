class OrderMailer < ApplicationMailer

  add_template_helper(ApplicationHelper)

  def order_purchase(order)
    @order = order
    @total_price = @order.total_price
    @brief_request = @order.brief_request
    @email = @brief_request.email
    @customer_name = @brief_request.name
    @purchase_time = DateTime.now

    @mail_to = "ant.khay@gmail.com, jordan@neuralle.com, lauren@neuralle.com"
    # @mail_to = "ant.khay@gmail.com"

    mail(to: @mail_to, subject: "New purchase at neuralle.com: #{@customer_name}, #{@purchase_time.strftime("%m/%d/%Y at %I:%M %p")}, $#{@total_price}")
  end

end
