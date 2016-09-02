get '/' do
  @urls = Url.all.order("click_count DESC")
  erb :"static/index"
end

post '/urls' do
  url = Url.find_by_long_url(params[:long_url])
  if url
    return { flash: "#{url.long_url} has already been added before." }.to_json
    # @urls = Url.all.order("click_count DESC")
    # erb :'static/index'

  else
    if !params[:long_url].empty?
      url = Url.new(long_url: params[:long_url])
      url.shorten
      if url.save
        return { url: url }.to_json
      else
        return { flash: "Invalid URL. Did you include 'http://' or 'https://'?"}.to_json
      end
    else
      return { flash: "URL cannot be blank!" }.to_json
    end
    # @urls = Url.all.order("click_count DESC")
    # erb :'static/index'
  end
end

get '/:short_url' do
  url = Url.find_by_short_url(params[:short_url])
  url.add_click_count
  redirect to url.long_url
end