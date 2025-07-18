local multiline_str = require('genzade.core.utils').sanitize_str

M = {}

-- TODO: Add more projections for work
M.ruby_generic = {
  ['lib/*.rb'] = { alternate = 'spec/lib/{}_spec.rb', type = 'source' },
  ['spec/lib/*_spec.rb'] = {
    alternate = 'lib/{}.rb',
    type = 'spec',
    template = {
      multiline_str([[
        # frozen_string_literal: true

        require 'spec_helper'

        RSpec.describe {camelcase|capitalize|colons} do
          it 'does something' do
            expect(true).to eq(false)
          end
        end]]),
    },
  },
}

M.ruby_on_rails = {
  ['app/adapters/*.rb'] = {
    alternate = 'spec/adapters/{}_spec.rb',
    type = 'source',
  },
  ['spec/adapters/*_spec.rb'] = {
    alternate = 'app/adapters/{}.rb',
    type = 'spec',
    template = {
      multiline_str([[
        # frozen_string_literal: true

        require 'rails_helper'

        RSpec.describe {camelcase|capitalize|colons}, type: :adapter do
          describe '#METHOD' do
            it 'does something helpful' do
              expect(described_class.METHOD).to eq('expected value')
            end
          end
        end]]),
    },
  },
  ['app/helpers/*.rb'] = {
    alternate = 'spec/helpers/{}_spec.rb',
    type = 'source',
  },
  ['spec/helpers/*_spec.rb'] = {
    alternate = 'app/helpers/{}.rb',
    type = 'spec',
    template = {
      multiline_str([[
        # frozen_string_literal: true

        require 'rails_helper'

        RSpec.describe {camelcase|capitalize|colons}, type: :helper do
          describe '#METHOD' do
            it 'does something helpful' do
              expected = <<~HTML
                <div class="some-class
                  some-other-class">
                  <p>Some content</p>
                </div>
              HTML
              expect(helper.METHOD).to eq(expected)
            end
          end
        end]]),
    },
  },
  ['app/models/*.rb'] = {
    alternate = 'spec/models/{}_spec.rb',
    type = 'source',
  },
  ['spec/models/*_spec.rb'] = {
    alternate = 'app/models/{}.rb',
    type = 'spec',
    template = {
      multiline_str([[
        # frozen_string_literal: true

        require 'rails_helper'

        RSpec.describe {camelcase|capitalize|colons}, type: :model do
          describe 'associations' do
            it {open} is_expected.to belong_to(:association) {close}
            it {open} is_expected.to have_many(:association) {close}
          end

          describe 'validations' do
            it {open} is_expected.to validate_presence_of(:attribute) {close}
          end
        end]]),
    },
  },
  ['app/forms/*.rb'] = {
    alternate = 'spec/forms/{}_spec.rb',
    type = 'source',
  },
  ['spec/forms/*_spec.rb'] = {
    alternate = 'app/forms/{}.rb',
    type = 'spec',
    template = {
      multiline_str([[
        # frozen_string_literal: true

        require 'rails_helper'

        RSpec.describe {camelcase|capitalize|colons}, type: :form do
          describe 'validations' do
            it {open} is_expected.to validate_presence_of(:attribute) {close}
          end

          describe "#save" do
            context "when the form is valid" do
              it "creates a RECORD, returns true" do
                form = {camelcase|capitalize|colons}.new(
                  foo: "john@doe.com",
                  bar: "123456",
                )

                expect do
                  expect(form.save).to be(true)
                  expect(form.errors).to be_empty
                end.to change(RECORD, :count).from(0).to(1)
              end
            end

            context "when the form is invalid" do
              it "does not create RECORD returns false" do
                form = {camelcase|capitalize|colons}.new(
                  foo: "",
                  bar: "",
                )

                expect do
                  expect(form.save).to be(false)
                  expect(form.errors).not_to be_empty
                end.not_to change(RECORD, :count)
              end
            end
          end
        end]]),
    },
  },
  ['app/views/*.html.erb'] = {
    alternate = 'spec/views/{}.html.erb_spec.rb',
    type = 'source',
  },
  ['app/components/*.rb'] = {
    alternate = {
      'app/components/{}.html.erb',
      'spec/components/{}_spec.rb',
    },
    type = 'component',
  },
  ['app/components/*.html.erb'] = {
    alternate = { 'spec/components/{}_spec.rb', 'app/components/{}.rb' },
    type = 'component',
  },
  ['spec/components/*_spec.rb'] = {
    alternate = { 'app/components/{}.rb', 'app/components/{}.html.erb' },
    type = 'component',
    template = {
      multiline_str([[
        # frozen_string_literal: true

        require 'rails_helper'

        RSpec.describe {camelcase|capitalize|colons}, type: :component do
          it 'renders the component' do
            render_inline({camelcase|capitalize|colons}.new)

            expect(page).to have_css('div')
          end
        end]]),
    },
  },
  ['spec/views/*.html.erb_spec.rb'] = {
    alternate = 'app/views/{}.html.erb',
    type = 'spec',
  },
  ['lib/*.rb'] = { alternate = 'spec/lib/{}_spec.rb', type = 'source' },
  ['spec/lib/*_spec.rb'] = {
    alternate = 'lib/{}.rb',
    type = 'spec',
    template = {
      multiline_str([[
      # frozen_string_literal: true

      require 'rails_helper'

      RSpec.describe {camelcase|capitalize|colons} do
         it 'does something' do
           expect(true).to eq(false)
         end
       end]]),
    },
  },
  ['lib/tasks/*.rake'] = {
    alternate = 'spec/lib/tasks/{}_spec.rb',
    type = 'source',
  },
  ['spec/lib/tasks/*_spec.rb'] = {
    alternate = 'lib/tasks/{}.rake',
    type = 'spec',
    template = {
      multiline_str([[
        # frozen_string_literal: true

        require 'rails_helper'

        # loads all the rake tasks
        Rails.application.load_tasks

        RSpec.describe Tasks::{camelcase|capitalize|colons} type: :task do
          def rake_task
            Rake::Task['{dirname}:{basename}:run']
          end

          after {open} rake_task.reenable {close}

          before do
            :something
          end

          it does something useful do
            expect do
              rake_task.invoke
            end.to change {open} :some_record {close}
              .from(:this)
              .to(:that)
              .and(
                change {open} :other_record {close}
                  .from(:this)
                  .to(:that)
              )
          end
        end]]),
    },
  },
  ['app/mailers/*.rb'] = {
    alternate = 'spec/mailers/{}_spec.rb',
    type = 'source',
  },
  ['spec/mailers/*_spec.rb'] = {
    alternate = 'app/mailers/{}.rb',
    type = 'spec',
    template = {
      multiline_str([[
        # frozen_string_literal: true

        require 'rails_helper'

        RSpec.describe {camelcase|capitalize|colons} type: :mailer do
          describe '#mailer_method_name' do
            it 'sends an email with correct content' :aggregate_failures do
              mail = {camelcase|capitalize|colons}
                .with(key: :value)
                .mailer_method_name

              expect(mail.to).to eq(['user@mail.com'])
              expect(mail.bcc).to eq(['other_user@mail.com'])
              expect(mail.subject).to eq('Subject line here')
              expect(mail.html_part.encoded).to include(
                'User Bruce Wayne has create to their account:'
              )
              expect(mail.text_part.encoded).to include(
                'User Bruce Wayne has create to their account:'
              )
            end
          end
        end]]),
    },
  },
  ['app/services/*.rb'] = {
    alternate = 'spec/services/{}_spec.rb',
    type = 'source',
  },
  ['spec/services/*_spec.rb'] = {
    alternate = 'app/services/{}.rb',
    type = 'spec',
    template = {
      multiline_str([[
        # frozen_string_literal: true

        require 'rails_helper'

        RSpec.describe {camelcase|capitalize|colons}, type: :service do
          describe '#METHOD' do
            it 'does something helpful' do
              expect(described_class.METHOD).to eq('expected value')
            end
          end
        end]]),
    },
  },
  ['app/jobs/*.rb'] = {
    alternate = 'spec/jobs/{}_spec.rb',
    type = 'source',
  },
  ['spec/jobs/*_spec.rb'] = {
    alternate = 'app/jobs/{}.rb',
    type = 'spec',
    template = {
      multiline_str([[
        # frozen_string_literal: true

        require 'rails_helper'

        RSpec.describe {camelcase|capitalize|colons}, type: :job do
          it 'does something' do
            expect(true).to eq(false)
          end
        end]]),
    },
  },
  ['app/sidekiq/*.rb'] = {
    alternate = 'spec/sidekiq/{}_spec.rb',
    type = 'source',
  },
  ['spec/sidekiq/*_spec.rb'] = {
    alternate = 'app/sidekiq/{}.rb',
    type = 'spec',
    template = {
      multiline_str([[
        # frozen_string_literal: true

        require 'rails_helper'

        RSpec.describe {camelcase|capitalize|colons}, type: :job do
          it "enqueues itself on default queue" do
            arg = 123

            expect { {camelcase|capitalize|colons}.perform_async(arg) }
              .to enqueue_sidekiq_job({camelcase|capitalize|colons})
              .with(arg)
              .on("default")
          end
        end]]),
    },
  },
  ['app/channels/*.rb'] = {
    alternate = 'spec/channels/{}_spec.rb',
    type = 'source',
  },
  ['spec/channels/*_spec.rb'] = {
    alternate = 'app/channels/{}.rb',
    type = 'spec',
    template = {
      multiline_str([[
        # frozen_string_literal: true

        require 'rails_helper'

        RSpec.describe {camelcase|capitalize|colons}, type: :channel do
          it 'does something' do
            expect(true).to eq(false)
          end
        end]]),
    },
  },
  ['rubocop/cop/*.rb'] = {
    alternate = 'spec/rubocop/cop/{}_spec.rb',
    type = 'source',
  },
  ['spec/rubocop/cop/*_spec.rb'] = {
    alternate = 'rubocop/cop/{}.rb',
    type = 'test',
  },
  ['app/operations/*.rb'] = {
    alternate = 'spec/operations/{}_spec.rb',
    type = 'source',
  },
  ['spec/operations/*_spec.rb'] = {
    alternate = 'app/operations/{}.rb',
    type = 'spec',
    template = {
      multiline_str([[
        # frozen_string_literal: true

        require 'rails_helper'

        RSpec.describe {camelcase|capitalize|colons} do
          it 'does something' do
            expect(true).to eq(false)
          end
        end]]),
    },
  },
  ['app/presenters/*.rb'] = {
    alternate = 'spec/presenters/{}_spec.rb',
    type = 'source',
  },
  ['spec/presenters/*_spec.rb'] = {
    alternate = 'app/presenters/{}.rb',
    type = 'spec',
    template = {
      multiline_str([[
        # frozen_string_literal: true

        require 'rails_helper'

        RSpec.describe {camelcase|capitalize|colons} do
          it 'does something' do
            expect(true).to eq(false)
          end
        end]]),
    },
  },
  ['app/resources/*.rb'] = {
    alternate = 'spec/resources/{}_spec.rb',
    type = 'source',
  },
  ['spec/resources/*_spec.rb'] = {
    alternate = 'app/resources/{}.rb',
    type = 'spec',
    template = {
      multiline_str([[
        # frozen_string_literal: true

        require 'rails_helper'

        RSpec.describe {camelcase|capitalize|colons}, type: :resource do
          it 'does something' do
            expect(true).to eq(false)
          end
        end]]),
    },
  },
}

return M
