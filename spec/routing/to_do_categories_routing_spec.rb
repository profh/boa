require "spec_helper"

describe ToDoCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/to_do_categories").should route_to("to_do_categories#index")
    end

    it "routes to #new" do
      get("/to_do_categories/new").should route_to("to_do_categories#new")
    end

    it "routes to #show" do
      get("/to_do_categories/1").should route_to("to_do_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/to_do_categories/1/edit").should route_to("to_do_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/to_do_categories").should route_to("to_do_categories#create")
    end

    it "routes to #update" do
      put("/to_do_categories/1").should route_to("to_do_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/to_do_categories/1").should route_to("to_do_categories#destroy", :id => "1")
    end

  end
end
