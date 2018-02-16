using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(NedbankCallCenterApplication.Startup))]
namespace NedbankCallCenterApplication
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
