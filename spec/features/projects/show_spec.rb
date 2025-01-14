require 'rails_helper'

RSpec.describe Project do
  describe 'user story 1' do
    describe 'when I visit /projects/:id' do
      it 'shows the project name and materials and the theme of the project challenge' do
        recycled_material_challenge = Challenge.create!(theme: "Recycled Material", project_budget: 1000)
        furniture_challenge = Challenge.create!(theme: "Apartment Furnishings", project_budget: 1000)
        news_chic = recycled_material_challenge.projects.create!(name: "News Chic", material: "Newspaper")
        boardfit = recycled_material_challenge.projects.create!(name: "Boardfit", material: "Cardboard Boxes")
        upholstery_tux = furniture_challenge.projects.create!(name: "Upholstery Tuxedo", material: "Couch")
        lit_fit = furniture_challenge.projects.create!(name: "Litfit", material: "Lamp")

        visit "/projects/#{lit_fit.id}"
        
        expect(page).to have_content("Challenge Theme: Apartment Furnishings")
        expect(page).to have_content("Material: Lamp")
        expect(page).to have_content("Challenge Name: Litfit")
      end
    end
  end

  describe 'user story 3' do
    describe 'when I visit a project show page' do
      it 'shows a count of the number of contestants on this project' do

        recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
        furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
        news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
        boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
        upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
        lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

        jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
        gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
        kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
        erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)

        ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)
        ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
        ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)
        ContestantProject.create(contestant_id: erin.id, project_id: boardfit.id)

        visit "/projects/#{news_chic.id}"
        expect(page).to have_content("Number of Contestants: 2")
      end
    end
  end
end