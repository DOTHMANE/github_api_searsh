# frozen_string_literal: true

class RepositoriesController < ApplicationController
  def index
    if params['search'].present?
      @req = GithubApiService.new(params)
      result = @req.request_repositories

      if result.status == 200
        @repositories = JSON.parse(result.body)['items']
      else
        @error = JSON.parse(result.body)['message']
      end
    else
      @repositories = []
    end

  end
end
