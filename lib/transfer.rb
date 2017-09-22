class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if sender.balance < amount || sender.valid? == false
        @status = "rejected"
        return "Transaction rejected. Please check your account balance."
    end
    return nil if @status == "complete"
    receiver.deposit(amount)
    sender.balance -= amount
    @status = "complete"
  end

  def reverse_transfer
    return nil if @status != "complete"
    receiver.balance -= amount
    sender.deposit(amount)
    @status = "reversed"
  end
end
