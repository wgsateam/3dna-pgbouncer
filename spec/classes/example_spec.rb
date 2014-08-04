require 'spec_helper'

describe 'pgbouncer' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "pgbouncer class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('pgbouncer::params') }
        it { should contain_class('pgbouncer::install').that_comes_before('pgbouncer::config') }
        it { should contain_class('pgbouncer::config') }
        it { should contain_class('pgbouncer::service').that_subscribes_to('pgbouncer::config') }

        it { should contain_service('pgbouncer') }
        it { should contain_package('pgbouncer').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'pgbouncer class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('pgbouncer') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
