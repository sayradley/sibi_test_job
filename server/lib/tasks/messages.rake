namespace :messages do
  desc 'Starts messages fetching background job'
  task :start_job do
    MessagesFetcherJob.perform_later
  end
end
