class AdPlatformsController < InheritedResources::Base

  actions  :new, :create, :edit, :update, :destroy

  def create
    create! { root_url }
  end

  def update
    update! { root_url }
  end


  protected

    def begin_of_association_chain
      current_user
    end

end
