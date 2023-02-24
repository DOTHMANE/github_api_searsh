# frozen_string_literal: true

class GithubApiService
  attr_reader :page, :query

  # initialize service vars
  def initialize(params)
    @con = Faraday.new(url: 'https://api.github.com', headers: { 'Content-Type' => 'application/vnd.github+json' })
    @query = params[:query].nil? ? construct_query(params) : params[:query]
    @page = params[:page].nil? || params[:page].to_i < 1 ? 1 : params[:page]
    @per_page = params['per_page']
  end

  # function to request repositories
  def request_repositories
    @con.get('/search/repositories') do |req|
      req.params['q'] = @query
      req.params['per_page'] = @per_page
      req.params['page'] = @page
    end
  end

  private

  # construct search query
  def construct_query(params)
    query = params['search']
    query += ' in:name' if params['name'] == '1'
    query += ' in:topics' if params['topics'] == '1'
    query += ' in:description' if params['description'] == '1'
    query += ' in:readme' if params['readme'] == '1'
    query += params['sort']

    query
  end
end
