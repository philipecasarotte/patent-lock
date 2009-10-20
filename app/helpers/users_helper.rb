module UsersHelper
  def go_to_current_order_state
    if current_user.order
      case current_user.order.state
        when "pending_answers"
          questionnaire_step1_path
        when "pending_terms"
          questionnaire_terms_path
        when "pending_payment"
          questionnaire_payment_path
        when "pending_confirmation"
          questionnaire_confirmation_path
        when "confirmed"
          questionnaire_thankyou_path
        else
          user_path(current_user)
      end
    else
      questionnaire_step1_path
    end rescue new_user_path
  end
end
