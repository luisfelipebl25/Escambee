require 'rails_helper'

RSpec.describe Resource::GameFetcher do
  describe '#fetch' do
    let(:fetch_method) do
      ->(id) { double(id: id, name: "Peter Jackson's King Kong, The Video Game of The Movie", image: 'https://image.url') }
    end
    subject { described_class.new fetch_method }

    it 'traz o objeto baseado no método enviado' do
      expect(subject.fetch(175).id).to eq(175)
    end

    it 'armazena num cache interno resultados de buscas anteriores' do
      allow(subject).to receive(:fetch_method).and_return(fetch_method)
      subject.fetch(1)
      expect(subject).to_not receive(:fetch_method)
      subject.fetch(1)
    end
  end
end
