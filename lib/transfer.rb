#account number its coming from, going to, and amount

class Transfer

  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction

    if self.valid? && self.amount < self.sender.balance && self.status == "pending"
      #execute transaction
      self.sender.withdrawl(self.amount)
      self.receiver.deposit(self.amount)
      self.status = "complete"
    else
      #reject transaction
      self.status = "rejected"
      "Transaction rejected. Please check your account balance." 
    end

  end

  def reverse_transfer

    if self.valid? && self.amount < self.receiver.balance && self.status == "complete"
      self.receiver.withdrawl(self.amount)
      self.sender.deposit(self.amount)
      self.status = "reversed"
    end

  end

end

