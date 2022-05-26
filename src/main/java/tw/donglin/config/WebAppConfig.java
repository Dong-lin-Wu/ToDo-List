package tw.donglin.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "tw.donglin")
public class WebAppConfig implements WebMvcConfigurer {

	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}
	
	@Bean
	public InternalResourceViewResolver viewResolver() {
		InternalResourceViewResolver irvr = new InternalResourceViewResolver();
		irvr.setPrefix("/WEB-INF/pages/");
		irvr.setSuffix(".jsp");
		irvr.setOrder(6);
		return irvr;
		
	}
	
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addRedirectViewController("/", "/index");
		
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
//		registry.addResourceHandler("/images/**").addResourceLocations("/WEB-INF/resources/images/");
//		registry.addResourceHandler("/css/**").addResourceLocations("/WEB-INF/resources/css/");
//		registry.addResourceHandler("/js/**").addResourceLocations("WEB-INF/resources/js");
	}

	//上傳檔案 若要將整個form送出，則需要此段
//	@Bean
//	public CommonsMultipartResolver multipartResolver() {
//		CommonsMultipartResolver cmr = new CommonsMultipartResolver();
//		cmr.setDefaultEncoding("utf-8");
//		return cmr;
//	}
	
//	@Bean //解析json格式
//	public MappingJackson2JsonView mJackson2JsonView() {
//		MappingJackson2JsonView mjv = new MappingJackson2JsonView();
//		mjv.setPrettyPrint(true);
//		return mjv;
//	}
//	
//	@Bean
//	public Jaxb2Marshaller jaxb2Marshaller() {
//		 Jaxb2Marshaller jaxb2 = new Jaxb2Marshaller();
//		 jaxb2.setPackagesToScan("tw.leonchen");
//		 return jaxb2;
//		 
//	}
//	
//	@Bean
//	public ContentNegotiatingViewResolver cResolver() {
//		ContentNegotiatingViewResolver cnvr = new ContentNegotiatingViewResolver();
//		ArrayList<ViewResolver> resolver = new ArrayList<ViewResolver>();
//		cnvr.setViewResolvers(resolver);
//		
//		List<View> defaultview = new ArrayList<View>();
//		defaultview.add(new MappingJackson2JsonView());
//		cnvr.setDefaultViews(defaultview);
//		
//		return cnvr;
//	}
//	
	
	
	
}
