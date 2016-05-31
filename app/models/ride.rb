class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if unqualified?
      unqualified?
    elsif
      update_user
      self.user.save
    end
  end

  def update_user
    update_user_tickets
    update_user_naseau
    update_user_happiness
  end

  def update_user_naseau
    self.user.nausea= self.user.nausea + self.attraction.nausea_rating
  end

  def update_user_happiness
    self.user.happiness= self.user.happiness + self.attraction.happiness_rating
  end

  def update_user_tickets
    self.user.tickets = self.user.tickets - self.attraction.tickets
    self.user.save
  end

  def unqualified?
    if no_tickets_short?
      no_tickets_short?
    else enough_tickets? || tall_enough?
      enough_tickets? || tall_enough?
    end
  end

  def no_tickets_short?
    if enough_tickets? && tall_enough?
      "Sorry. You do not have enough tickets the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
    end
  end

  def enough_tickets?
    if self.attraction.tickets > self.user.tickets
      "Sorry. You do not have enough tickets the #{self.attraction.name}."
    end
  end

  def tall_enough?
    if self.attraction.min_height > self.user.height
      "Sorry. You are not tall enough to ride the #{self.attraction.name}."
    end
  end


end
