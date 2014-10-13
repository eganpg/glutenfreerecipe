require 'open-uri'
 class SearchesController < ApplicationController
  def index
    @name = User.all
   end
   def new
   	@search = Searches.new
   end
   def create
    @name = User.all.reverse
    urlmeta = "http://api.yummly.com/v1/api/metadata/allergy?_app_id=a1c433e1&_app_key=c233031482ae3bce20a06083aa19d47f"
    responsemeta = HTTParty.get(urlmeta)
   	search = params[:search]
    clean_search = search.tr(' ', '+')
    
   	url = "http://api.yummly.com/v1/api/recipes?_app_id=a1c433e1&_app_key=2de27003828941dce82fb211b78f4425&q=" + clean_search + "&allowedAllergy[]=393%5EGluten-Free&maxResult=50"
   	response = HTTParty.get(url)
   	@matches = response["matches"]
    @user = User.create(name: search)

    
    render new_search_path
   end	 
		def edit
			@id = params[:id]
			url = "http://api.yummly.com/v1/api/recipe/" + @id + "?_app_id=a1c433e1&_app_key=c233031482ae3bce20a06083aa19d47f"
			response = HTTParty.get(url)
      r = JSON.parse(response.body)
      
      @s = r["source"]["sourceRecipeUrl"]
      redirect_to @s

			
# Brown, sear, dice, fold, pan sauce, roux, segment, temper, vinagarette, roast, deep fry, pan fry, saute, sweat, 
# touch, flambe, blanch, boil, braise, poach, scald, simmer, steam, batonnet, allumette, dice, julienne, brunoise, peel, slice, chiffonade, mince, defrost

  #     if open(@s).read =~ /brown/
  #       @brown = open(@s).read
  #       raise @brown.inspect
  #       @sear = "This recipe contains the word Brown"
  #     end
  #     if open(@s).read =~ /sear/
  #       @sear = "This recipe contains the word Sear"
  #     end
  #     if open(@s).read =~ /dice/
  #       @dice = "This recipe contains the word Dice"
  #     end
  #     if open(@s).read =~ /fold/
  #       @fold = "This recipe contains the word Fold"
  #     end
  #     if open(@s).read =~ /pan sauce/
  #       @pansauce = "This recipe contains the word Pan Sauce"
  #     end
  #     if open(@s).read =~ /roux/
  #       @roux = "This recipe contains the word Roux"
  #     end
  #     if open(@s).read =~ /boil/
  #       @boil = "This recipe contains the word Boil"
  #     end
  #     if open(@s).read =~ /simmer/
  #       @simmer = "This recipe contains the word Simmer"
  #     end
      

		# 	puts response
	 end

   	 
   
end
