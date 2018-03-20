class PersonDataService
  def person_list
    q = []
    Product.all.each do |product|
      next if product.step_ids.empty?
      product_ids = product.step_ids.join(',')

      q << "(SELECT people_steps.*
                FROM people_steps INNER JOIN people ON people_steps.person_id = people.id INNER JOIN
                  (
                    SELECT person_id, MAX(created_at) as latest_time
                    FROM people_steps
                    WHERE step_id IN (#{product_ids})
                    GROUP BY person_id
                  ) as T ON people_steps.person_id = T.person_id
                WHERE people_steps.deleted_at IS NULL AND people_steps.step_id IN (#{product_ids})
                      AND T.latest_time = people_steps.created_at AND people.status <> #{Person.statuses[:archive]}
                )"
    end

    query = "SELECT ps.*
         FROM (#{q.join(' UNION ALL ')}) AS ps INNER JOIN people ON ps.person_id = people.id
         ORDER BY
         CASE people.status
          WHEN #{Person.statuses[:lead]} THEN 1
          WHEN #{Person.statuses[:prospect]} THEN 2
          WHEN #{Person.statuses[:customer]} THEN 3
         END"

    _results = q.empty? ? [] : PeopleStep.find_by_sql(query)
  rescue TypeError => e
    "ProspectDataService #{e.message}"
  end

  # Check NIC  number
  # Input: nic_number and product_id params
  # Output:
  # ==== true: not exists product for this person
  # ==== false: exists product for this person
  def nic_validate?(nic_number, product_id)
    person = Person.find_by_nic_number(nic_number)
    return true unless person
    step_ids = Step.where(product_id: product_id).ids
    person_product = PeopleStep.where(person: person, step_id: step_ids).where.not(status: [:done, :canceled])
    return true if person_product.empty?
    false
  end
end
