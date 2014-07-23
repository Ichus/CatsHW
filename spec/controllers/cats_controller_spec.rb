require 'rails_helper'

describe CatsController do
  it 'GET :index' do
    cats = create_list(:cat, 2)
    get :index, format: :json
    data = JSON.parse(response.body)
    expect(data.size).to eq 2
    expect(data.first).to have_key('name')
    expect(data.first['name']).to eq cats.first.name
  end

  it 'GET :show' do
    cat = create(:cat)
    get :show, id: cat.id,format: :json
    data = JSON.parse(response.body)
    expect(data).to have_key('name')
    expect(data['name']).to eq cat.name
  end

  describe 'POST :create' do
    before { @cat_attributes = attributes_for(:cat) }
    it 'succeeds when all attributes are set' do
      post :create, cat: @cat_attributes, format: :json
      expect(response).to have_http_status(:created)
      data = JSON.parse(response.body)
      expect(data).to have_key('name')
      expect(data['name']).to eq @cat_attributes[:name]
    end

    it 'fails when a required field is missing' do
      @cat_attributes[:name] = nil
      post :create, cat: @cat_attributes, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  it 'PATCH :update' do
    cat = create(:cat)
    patch :update, id: cat.id, cat: {name: 'Jasmine'}, format: :json
    expect(response).to have_http_status(:no_content)
    expect(Cat.find(cat.id).name).to eq 'Jasmine'
  end

  it 'DELETE :destroy' do
    cat = create(:cat)
    delete :destroy, id: cat.id, format: :json
    expect(response).to have_http_status(:no_content)
    expect{Cat.find(cat.id)}.to raise_error ActiveRecord::RecordNotFound
  end
end
