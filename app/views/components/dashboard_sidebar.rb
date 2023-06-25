# frozen_string_literal: true

module Views
  module Components
    class DashboardSidebar < ApplicationComponent
      def initialize(models)
        @models = models
      end

      def template(&)
        nav(class: 'fixed left-0 top-0 z-[1035] h-full w-60 overflow-y bg-zinc-800 shadow-[0_4px_12px_0_rgba(0,0,0,0.07),_0_2px_4px_rgba(0,0,0,0.05)]') do
          ul(class: 'relative m-0 list-none px-[0.2rem]') do
            @models.each do |model|
              li(class: 'relative') do
                a(class: 'flex h-12 cursor-pointer items-center truncate rounded-[5px] px-6 py-4 text-[0.875rem] text-gray-300 outline-none transition duration-300 ease-linear hover:bg-white/10 hover:outline-none focus:bg-white/10 focus:outline-none active:bg-white/10 active:outline-none :outline-none motion-reduce:transition-none') do
                  span(class: 'mr-4') do
                    model
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
