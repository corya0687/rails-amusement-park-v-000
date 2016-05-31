class User < ActiveRecord::Base
  has_many :rides
  has_many :attractions, :through => :rides
  has_secure_password

  def mood
    sad || happy
  end

  def sad
    if !self.nausea.nil?
    "sad" if self.nausea > self.happiness
    end
  end

  def happy
    if !self.nausea.nil?

    "happy" if self.nausea < self.happiness
    end
    
  end
end
