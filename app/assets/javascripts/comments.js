function toggleReply(el)
{
	jQuery(el).closest('.comment').find('.reply-form').toggle();
}