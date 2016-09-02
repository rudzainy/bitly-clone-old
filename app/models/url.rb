class Url < ActiveRecord::Base

  validates :short_url, uniqueness: true, presence: true
  validates :long_url, uniqueness: true, presence: true, format: { with: URI.regexp }, if: Proc.new { |a| a.long_url.present? }

	def shorten
    self.short_url = ([*('A'..'Z'),*('0'..'9')]-%w(0 1 I O)).sample(8).join
  end

  def add_click_count
    self.update(click_count: self.click_count + 1)
  end
end
