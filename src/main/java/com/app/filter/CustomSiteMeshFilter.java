package com.app.filter;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // Decorator for Authentication pages
        builder.addDecoratorPath("/login", "/WEB-INF/decorators/auth.jsp")
               .addDecoratorPath("/register", "/WEB-INF/decorators/auth.jsp")
               .addDecoratorPath("/forgot-password", "/WEB-INF/decorators/auth.jsp")
               .addDecoratorPath("/verify-otp", "/WEB-INF/decorators/auth.jsp")
               .addDecoratorPath("/reset-password", "/WEB-INF/decorators/auth.jsp")
               .addDecoratorPath("/views/login.jsp", "/WEB-INF/decorators/auth.jsp")
               .addDecoratorPath("/views/register.jsp", "/WEB-INF/decorators/auth.jsp")
               .addDecoratorPath("/views/forgot-password.jsp", "/WEB-INF/decorators/auth.jsp")
               .addDecoratorPath("/views/verify-otp.jsp", "/WEB-INF/decorators/auth.jsp")
               .addDecoratorPath("/views/reset-password.jsp", "/WEB-INF/decorators/auth.jsp");

        // Main Web Decorator for all application pages
        builder.addDecoratorPath("/*", "/WEB-INF/decorators/web.jsp");

        // Exclude static resources and internal files
        builder.addExcludedPath("/css/*")
               .addExcludedPath("/js/*")
               .addExcludedPath("/images/*")
               .addExcludedPath("/uploads/*")
               .addExcludedPath("/assets/*")
               .addExcludedPath("/WEB-INF/*");
    }
}
