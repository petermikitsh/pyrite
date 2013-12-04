json.array!(@papers) do |paper|
  json.extract! paper, :id, :title, :authors, :published_on, :journal, :volume, :issue, :pages, :url, :project_id
  json.url paper_url(paper, format: :json)
end
