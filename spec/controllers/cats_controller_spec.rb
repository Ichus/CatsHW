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

  it 'POST :create'
  it 'PATCH :update'
  it 'DELETE :destroy'
end
