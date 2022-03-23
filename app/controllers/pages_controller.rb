class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :journey ]
  require "json"

  def home
  end

  def journey
    # json = JSON.parse(File.read('./journey.json'));
    @json = {
      "Started Lewagon": {
        "Date": "Sep 9, 2021",
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
      }
    }
    # byebug
    # raise
  end
end
