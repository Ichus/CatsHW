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
      expect { create_cat_expect_status :created }.to change { Cat.count }.by(1)
      data = JSON.parse(response.body)
      expect(data).to have_key('name')
      expect(data['name']).to eq @cat_attributes[:name]
    end

    it 'fails when a required field is missing' do
      @cat_attributes[:name] = nil
      create_cat_expect_status :unprocessable_entity
    end

    it 'fails when extra paramters are required' do
      @cat_attributes[:invalid_param] = "invalid parameter"
      expect { post :create, cat: @cat_attributes, format: :json }.to raise_error(ActiveRecord::UnknownAttributeError)
    end

    it 'fails when string fields are greater than 255 characters' do
      string_array = Array.new
      300.times { string_array << "A" }
      long_string = string_array.join("")
      @cat_attributes[:name] = @cat_attributes[:breed] = @cat_attributes[:catchphrase] = long_string
      expect { post :create, cat: @cat_attributes, format: :json }.to raise_error(ActiveRecord::StatementInvalid)
    end

    def create_cat_expect_status(status)
      post :create, cat: @cat_attributes, format: :json
      expect(response).to have_http_status(status)
    end
  end

  describe 'PATCH :update' do
    before { @cat = create(:cat) }
    it 'succeeds when valid data are changed' do
      patch :update, id: @cat.id, cat: {name: 'Jasmine'}, format: :json
      expect(response).to have_http_status(:no_content)
      expect(Cat.find(@cat.id).name).to eq 'Jasmine'
    end

    it 'fails when a required field is missing' do
      cat_name = @cat.name
      patch :update, id: @cat.id, cat: {name: nil}, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Cat.find(@cat.id).name).to eq cat_name
    end
  end

  it 'DELETE :destroy' do
    cat = create(:cat)
    delete :destroy, id: cat.id, format: :json
    expect(response).to have_http_status(:no_content)
    expect{Cat.find(cat.id)}.to raise_error ActiveRecord::RecordNotFound
  end
end
