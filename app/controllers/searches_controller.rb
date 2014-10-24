require 'open-uri'
 class SearchesController < ApplicationController
  def index
    @name = User.all
   end
   def new
   	@search = Searches.new
   end
   def create
    @names = User.all.reverse
    @name = @names.take(30)
    

    #find meta information for sorting

    urlmeta = "http://api.yummly.com/v1/api/metadata/allergy?_app_id=a1c433e1&_app_key=c233031482ae3bce20a06083aa19d47f"
    responsemeta = HTTParty.get(urlmeta)
   	
    #locate search paramaters, remove spaces and replace with +

    search = params[:search]
    if (search.match(/\s+/))
      clean_search = search.gsub!(/\s+/,"+")
    else
      clean_search = search  
      
    end
    
    
    
    
    YUM_ID = 'a1c433e1'
    YUM_KEY = '29e369c9b05882a2c89015a863db4ae8'
    
    
   	
    #API Call

    url = "http://api.yummly.com/v1/api/recipes?_app_id=" + YUM_ID + "&_app_key=" + YUM_KEY + "&q=" + clean_search + "&allowedAllergy[]=393%5EGluten-Free&maxResult=50"
   	response = HTTParty.get(url)
   	@matches = response["matches"]
    

    

    #Store name of search in database
    searcher = search.gsub!("+"," ")
    
    if(searcher != nil)
    @user = User.create(name: searcher)
  else
    @user = User.create(name: search)
  end

    
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
