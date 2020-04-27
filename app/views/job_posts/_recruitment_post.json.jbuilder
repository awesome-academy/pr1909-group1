json.extract! recruitment_post, :id, :employer_id, :job_location, :job_type, :job_status, :post_priority,
              :salary_min, :salary_max, :post_title, :job_description, :job_expired_date,
              :created_at, :updated_at
json.url job_post_url(recruitment_post, format: :json)
