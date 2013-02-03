Name:           perl-Marla-Site
Version:        1.0
Release:        2%{?dist}
Summary:        TODO Write a one-line specfile summary

Group:          TODO Categorize this Perl module
License:        MIT
URL:            http://www.dafrito.com
Source0:        http://www.dafrito.com/marla-site.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildArch:      noarch
BuildRequires:  perl(ExtUtils::MakeMaker)
Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; echo $version))

%description
TODO Write a multi-line specfile description

%prep
%setup -q -n marla-site

%build
%{__perl} Makefile.PL INSTALLDIRS=vendor
make %{?_smp_mflags}

%install
rm -rf $RPM_BUILD_ROOT

make pure_install PERL_INSTALL_ROOT=$RPM_BUILD_ROOT

find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} \;
find $RPM_BUILD_ROOT -depth -type d -exec rmdir {} 2>/dev/null \;

%{_fixperms} $RPM_BUILD_ROOT/*

%check
TEST_POD=1 make test

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
# For noarch packages: vendorlib
%{perl_vendorlib}/*

%changelog
* Sun Feb 03 2013 Aaron Faanes <dafrito@gmail.com> - 1.0-2
- Changed up how Servers are installed

%changelog
* Thu Jan 31 2013 Aaron Faanes <dafrito@gmail.com> - 1.0
- Initial release
