module Api
  module V1
    class LinksController < ApplicationController
      def visited_links
        status = SaveLinksService.new.call(links_params)

        if status == 'OK'
          render json: { status: 'ok' }
        else
          render json: { status: { error: status } }
        end
      end

      def visited_domains
        domains = GetDomainsService.new(time_from, time_to).call

        if domains.present?
          render json: { domains: domains, status: 'ok'}
        else
          render json: { status: 'error' }
        end
      end

      private

      def links_params
        params[:links]
      end

      def time_from
        params[:from]
      end

      def time_to
        params[:to]
      end
    end
  end
end
