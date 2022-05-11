class BlogsController < ApplicationController
  skip_before_action :authenticate_user!, only: [  :journey ]
  
  def journey
    # json = JSON.parse(File.read('./journey.json'));
    @blogs = Blog.order(id: :desc)
    @json = {
      "Started Lewagon": {
        "date": "Sep 9, 2021",
        "experiences": "Array too long."
      },
      "worked on TwoByFour": {
        "Time Interval": "Roughly 2 weeks",
        "Team": ["Erika", "Byron", "Reyona", "Babin"],
        "experiences": ["Late night meetings.", "New ideas and new code."]
      },
      "graduated from Lewagon": {
        "date": "March 12, 2022",
        "image": "lewagon_completion.jpg"
      },
      "started working on Dynamism": {
        "date": "first week of April, 2022"
      },
      "volunteering for Mamoru": {
        "date": "April 25, 2022",
        "position": "React developer"
      }
    }
    # byebug
    # raise
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.languages = JSON.parse(params["blog"]["languages"])
    if @blog.save
      redirect_to journey_path
    else
      render :new
    end
  end
  
  def edit
    @blog = Blog.find(params[:id])
  end
  
  def update
    @blog = Blog.find(params[:id])
    @blog.languages = JSON.parse(params["blog"]["languages"])
    if @blog.update(blog_params)
      redirect_to journey_path
    else
      render :edit
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :url)
  end
end
