get '/' do
  erb :"static/index"
end

post '/urls' do
  url = Url.new(long_url: params[:long_url])
  url.shorten
  if url.save
    redirect to '/'
  else
    @flash = "Error"
    erb :'static/index'
  end
end

get '/:short_url' do
  url = Url.find_by_short_url(params[:short_url])
  redirect to url.long_url
end