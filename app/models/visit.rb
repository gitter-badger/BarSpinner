class Visit < Impression

  belongs_to :bar, counter_cache: true  

end