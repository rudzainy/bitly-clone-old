class Url < ActiveRecord::Base

  validates :short_url, uniqueness: true
  validates :long_url, uniqueness: true

	def shorten
    self.short_url = ([*('A'..'Z'),*('0'..'9')]-%w(0 1 I O)).sample(8).join
    self.shorten unless self.save
  end
end
